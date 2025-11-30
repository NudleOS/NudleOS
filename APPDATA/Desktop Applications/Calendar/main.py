#This is a graphical calendar application.
import tkinter as tk
from tkinter import ttk
from datetime import datetime, timedelta

class CalendarApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Calendar")

        self.current_date = datetime.now()

        self.create_widgets()
        self.update_calendar()

    def create_widgets(self):
        # Header Frame
        header_frame = tk.Frame(self.root)
        header_frame.pack(pady=10)

        self.prev_month_btn = tk.Button(header_frame, text="<", command=self.prev_month)
        self.prev_month_btn.pack(side=tk.LEFT, padx=5)

        self.month_year_label = tk.Label(header_frame, text="", font=("Arial", 16, "bold"))
        self.month_year_label.pack(side=tk.LEFT, padx=10)

        self.next_month_btn = tk.Button(header_frame, text=">", command=self.next_month)
        self.next_month_btn.pack(side=tk.LEFT, padx=5)

        # Calendar Frame
        calendar_frame = tk.Frame(self.root)
        calendar_frame.pack()

        # Day Headers
        days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        for i, day in enumerate(days):
            label = tk.Label(calendar_frame, text=day, font=("Arial", 10, "bold"), width=8, height=2, borderwidth=1, relief="solid")
            label.grid(row=0, column=i, padx=1, pady=1)

        # Day Cells
        self.day_cells = {}
        for row in range(1, 7):  # Max 6 weeks for a month
            for col in range(7):
                cell_frame = tk.Frame(calendar_frame, width=80, height=60, borderwidth=1, relief="solid")
                cell_frame.grid(row=row, column=col, padx=1, pady=1, sticky="nsew")
                cell_frame.grid_propagate(False) # Prevent widgets from resizing cell_frame

                day_label = tk.Label(cell_frame, text="", font=("Arial", 12), anchor="nw")
                day_label.pack(padx=2, pady=2, anchor="nw")

                event_label = tk.Label(cell_frame, text="", font=("Arial", 8), fg="blue", wraplength=76)
                event_label.pack(padx=2, pady=2, anchor="sw")

                self.day_cells[(row, col)] = {"frame": cell_frame, "day_label": day_label, "event_label": event_label}

    def update_calendar(self):
        self.month_year_label.config(text=self.current_date.strftime("%B %Y"))

        # Clear previous day numbers and events
        for widgets in self.day_cells.values():
            widgets["day_label"].config(text="")
            widgets["event_label"].config(text="")
            widgets["frame"].config(bg="white") # Reset background color

        # Calculate the first day of the month
        first_day_of_month = self.current_date.replace(day=1)
        # Calculate the weekday of the first day (Monday is 0, Sunday is 6)
        start_weekday = first_day_of_month.weekday()

        # Fill in the days
        current_day = first_day_of_month
        for row in range(1, 7):
            for col in range(7):
                if (row == 1 and col < start_weekday) or current_day.month != self.current_date.month:
                    # Empty cells before the start of the month or after the end of the month
                    pass
                else:
                    cell_info = self.day_cells[(row, col)]
                    cell_info["day_label"].config(text=str(current_day.day))

                    # Highlight today
                    if current_day.date() == datetime.now().date():
                        cell_info["frame"].config(bg="#d3d3d3") # Light gray background for today

                    # Add placeholder for events (you would fetch real events here)
                    # Example: if current_day.day == 15:
                    #     cell_info["event_label"].config(text="Meeting")

                    current_day += timedelta(days=1)

    def prev_month(self):
        self.current_date -= timedelta(days=30) # A simple way to go back a month
        self.current_date = self.current_date.replace(day=1) # Ensure we start at the beginning of the month
        self.update_calendar()

    def next_month(self):
        # Calculate the first day of the next month
        next_month_date = self.current_date.replace(day=1) + timedelta(days=32)
        self.current_date = next_month_date.replace(day=1)
        self.update_calendar()

if __name__ == "__main__":
    root = tk.Tk()
    app = CalendarApp(root)
    root.mainloop()
