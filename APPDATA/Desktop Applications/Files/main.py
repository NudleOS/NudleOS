import tkinter as tk
from tkinter import ttk
import os
class FileManager(ttk.Frame):
    def __init__(self, parent, *args, **kwargs):
        ttk.Frame.__init__(self, parent, *args, **kwargs)
        self.parent = parent
        self.pack(fill="both", expand=True)
        self.tree = ttk.Treeview(self, columns=("Size", "Type"), show="headings")
        self.tree.pack(side="left", fill="both", expand=True)
        self.tree.heading("Size", text="Size")
        self.tree.heading("Type", text="Type")
        self.path = "/"
        self.populate_tree(self.path)
        self.vsb = ttk.Scrollbar(self, orient="vertical", command=self.tree.yview)
        self.vsb.pack(side="right", fill="y")
        self.tree.configure(yscrollcommand=self.vsb.set)
    def populate_tree(self, path):
        self.tree.delete(*self.tree.get_children())
        for item in os.listdir(path):
            item_path = os.path.join(path, item)
            if os.path.isfile(item_path):
                file_size = os.path.getsize(item_path)
                self.tree.insert("", "end", text=item, values=(file_size, "File"))
            elif os.path.isdir(item_path):
                self.tree.insert("", "end", text=item, values=("", "Directory"))
if __name__ == "__main__":
    root = tk.Tk()
    root.title("File Manager")
    FileManager(root)
    root.mainloop()
