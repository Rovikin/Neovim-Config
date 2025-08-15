# My Neovim Configuration

This is a minimal and efficient Neovim configuration built from scratch with essential features for modern development workflows.

---

## Installation

### For Termux (Android)

1. **Install Neovim and Git**:
   ```bash
   pkg install neovim git
   ```

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/lzif/nvim ~/.config/nvim
   ```

```bash
nvim
```

# Shortcuts

| **Keybinding**       | **Mode** | **Description**                                                                 |
|-----------------------|----------|---------------------------------------------------------------------------------|
| `<Tab>`              | `n`      | Switch to the next buffer.                                                     |
| `<C-x>`              | `n`      | Close the current buffer.                                                      |
| `<C-n>`              | `n`      | Toggle the file explorer (NvimTree).                                           |
| `<C-f>`              | `n`      | Open Telescope to search for files.                                            |
| `<C-t>`              | `n`      | Open Telescope to live grep (search for text).                                 |
| `<C-b>`              | `n`      | Open Telescope to search through open buffers.                                 |
| `<C-s>`              | `n`      | Save the current file.                                                         |
| `<C-q>`              | `n`      | Quit the current window.                                                       |
| `<C-k>`              | `n`      | Show diagnostic information at the cursor position in the active buffer.       |
| `<C-j>`              | `n`      | Jump to the previous diagnostic in the active buffer.                          |
| `<C-l>`              | `n`      | Jump to the next diagnostic in the active buffer.                              |
| `<C-s>`              | `i`      | Save the file and return to insert mode.                                       |
| `<C-h>`              | `n`      | Clear search highlights.                                                       |
| `<C-p>`              | `n`, `v` | Format the file using `conform` with LSP fallback, synchronous, and a timeout. |

### Notes:
- **Mode**: 
  - `n` stands for **Normal mode**.
  - `i` stands for **Insert mode**.
  - `v` stands for **Visual mode**.
- **Diagnostics**: These are related to LSP (Language Server Protocol) diagnostics, which provide information about errors, warnings, etc., in the code.
- **Telescope**: A highly extendable fuzzy finder for Neovim, used for searching files, text, buffers, etc.
- **Conform**: A plugin used for formatting files, with support for LSP fallback and synchronous formatting.
=======
3. **Run Neovim**:
   ```bash
   nvim
   ```

---

## Keybindings

Here’s a list of essential keybindings to enhance your productivity:

| **Keybinding** | **Mode** | **Description**                                                                 |
|----------------|----------|---------------------------------------------------------------------------------|
| `<Tab>`        | `n`      | Switch to the next buffer.                                                     |
| `<C-x>`        | `n`      | Close the current buffer.                                                      |
| `<C-n>`        | `n`      | Toggle the file explorer (NvimTree).                                           |
| `<C-f>`        | `n`      | Open Telescope to search for files.                                            |
| `<C-t>`        | `n`      | Open Telescope to live grep (search for text).                                 |
| `<C-b>`        | `n`      | Open Telescope to search through open buffers.                                 |
| `<C-s>`        | `n`      | Save the current file.                                                         |
| `<C-q>`        | `n`      | Quit the current window.                                                       |
| `<C-k>`        | `n`      | Show diagnostic information at the cursor position in the active buffer.       |
| `<C-j>`        | `n`      | Jump to the previous diagnostic in the active buffer.                          |
| `<C-l>`        | `n`      | Jump to the next diagnostic in the active buffer.                              |
| `<C-s>`        | `i`      | Save the file and return to insert mode.                                       |
| `<C-h>`        | `n`      | Clear search highlights.                                                       |
| `<C-p>`        | `n`, `v` | Format the file using `conform` with LSP fallback, synchronous, and a timeout. |

---

### Notes

- **Modes**:
  - `n`: **Normal mode**.
  - `i`: **Insert mode**.
  - `v`: **Visual mode**.
- **Diagnostics**: Powered by LSP (Language Server Protocol) to provide real-time feedback on errors, warnings, and suggestions.
- **Telescope**: A powerful fuzzy finder for searching files, text, and buffers.
- **Conform**: A plugin for formatting files with LSP fallback and synchronous execution.

