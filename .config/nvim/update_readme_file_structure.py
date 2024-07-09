import os
import re


def generate_tree(rootdir, prefix="", is_root=True):
    """Generate a directory tree as a string, with the root labeled explicitly as 'nvim'."""
    items = os.listdir(rootdir)
    items.sort()
    paths = [os.path.join(rootdir, item) for item in items]
    tree_lines = []

    # Check if this is the root call to the function and label it 'nvim'
    if is_root:
        tree_lines.append(prefix + "nvim")
        prefix += "    "  # Adjust prefix for the contents of the nvim directory

    for path in paths:
        if os.path.isdir(path):
            tree_lines.append(f"{prefix}├── {os.path.basename(path)}")
            subtree = generate_tree(path, prefix + "│   ", is_root=False)
            tree_lines.extend(subtree)
        else:
            tree_lines.append(f"{prefix}├── {os.path.basename(path)}")

    # Replace last ├ with └ for the last item within each directory
    if tree_lines and not is_root:
        tree_lines[-1] = tree_lines[-1].replace("├──", "└──")

    return tree_lines


def update_readme(readme_path, new_tree):
    """Update or create the README file with the new directory tree."""
    new_tree_str = "\n".join(new_tree) + "\n"

    if not os.path.exists(readme_path):
        # Create a new file with header and empty code block
        with open(readme_path, "w", encoding="utf-8") as file:
            file.write("# Configuration Files\n\n## File Structure\n\n```")
            file.write(new_tree_str)
            file.write("```\n")
    else:
        # Read existing content
        with open(readme_path, "r", encoding="utf-8") as file:
            content = file.read()

        # Check if the tree structure block exists
        pattern = re.compile(r"(```\n)[\s\S]*?(```)")
        if pattern.search(content):
            # Replace existing tree block
            updated_content = re.sub(pattern, f"\\1{new_tree_str}\\2", content)
        else:
            # Append new tree block if not found
            updated_content = (
                content + "\n## File Structure\n\n```" + new_tree_str + "```\n"
            )

        # Write the updated or appended content back to the file
        with open(readme_path, "w", encoding="utf-8") as file:
            file.write(updated_content)


def main():
    nvim_config_dir = os.path.expanduser("~/.config/nvim")
    readme_path = os.path.join(nvim_config_dir, "README.md")

    # Generate new directory tree
    new_tree = generate_tree(nvim_config_dir)

    # Update README.md with new tree or create it if it doesn't exist
    update_readme(readme_path, new_tree)

    print("README.md has been updated or created with the new file structure.")


if __name__ == "__main__":
    main()
