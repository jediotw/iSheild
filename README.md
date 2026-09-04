# iSheild

> Your development environment should adapt to your day — not fight against it.

iSheild is a time-aware developer environment that automatically adapts your coding setup throughout the day.

Instead of forcing you to work with the same visual environment from morning to midnight, iSheild provides three carefully designed phases:

- 🌅 **Morning** — warm, light, comfortable
- ☀️ **Day** — balanced, focused, high-clarity
- 🌙 **Night** — deep, calm, reduced visual intensity

The goal is simple:

> **One development environment that follows your day.**

---

## ✨ What iSheild Changes

iSheild is designed to keep your development tools visually synchronized.

| Environment | Morning | Day | Night |
|---|:---:|:---:|:---:|
| VS Code | ✓ | ✓ | ✓ |
| Neovim | ✓ | ✓ | ✓ |
| Ptyxis Terminal | ✓ | ✓ | ✓ |
| tmux | ✓ | ✓ | ✓ |

All integrations use the same iSheild visual language and the same time-based phases.

---

## 🎨 The iSheild Phases

### 🌅 Morning — 06:00–11:59

A warm light environment designed for the beginning of the day.

```text
Background  #F7F1DF
Surface     #EEE8D5
Hover       #E5DFCC
Selection   #D9E3E3
Text        #263238
Muted       #687A80
Border      #D8D1BC
Accent      #268BD2
```

### ☀️ Day — 12:00–17:59

A balanced dark developer environment designed for focused daytime work.

```text
Background  #21252B
Surface     #282C34
Hover       #30343D
Selection   #3E4451
Text        #ABB2BF
Muted       #7F848E
Border      #3A3F4B
Accent      #61AFEF
```

### 🌙 Night — 18:00–05:59

A deeper, calmer environment designed for late-night development.

```text
Background  #1E1E1E
Surface     #252526
Hover       #2A2D2E
Selection   #264F78
Text        #D0D0D0
Muted       #858585
Border      #38383D
Accent      #569CD6
```

---

## 🕐 Automatic Schedule

iSheild uses the local system time:

```text
06:00–11:59    Morning
12:00–17:59    Day
18:00–05:59    Night
```

The phase changes automatically as the day progresses.

---

## ⚙️ How It Works

The core idea is simple:

```text
                 System Time
                      │
                      ▼
              ┌───────────────┐
              │ iSheild Phase  │
              │    Engine      │
              └───────┬───────┘
                      │
           ┌──────────┼──────────┐
           ▼          ▼          ▼
        Morning      Day       Night
           │          │          │
           └──────────┼──────────┘
                      ▼
             Developer Environment
                      │
       ┌──────────────┼──────────────┐
       ▼              ▼              ▼
    Editor         Terminal         tmux
```

For the Linux terminal integration, a systemd user timer periodically runs the iSheild terminal service.

```text
systemd timer
     │
     ▼
iSheild terminal service
     │
     ├── Ptyxis palette
     │
     └── tmux theme
```

This allows the environment to stay synchronized without requiring manual theme changes.

---

# 🖥️ Linux Terminal Integration

The current terminal integration targets **GNOME Ptyxis**.

It provides three custom terminal palettes:

```text
terminal/palettes/
├── isheild-morning.palette
├── isheild-day.palette
└── isheild-night.palette
```

The installer places these palettes into the user's Ptyxis palette directory and configures the default Ptyxis profile.

The terminal phase is then automatically updated by the iSheild systemd user timer.

---

# 🧩 tmux Integration

iSheild also adapts the tmux interface.

The iSheild tmux theme controls:

- status bar
- active and inactive windows
- pane borders
- messages
- command messages
- copy mode
- popups
- menus
- clock mode

The same iSheild phase is used across the terminal and tmux.

The architecture is:

```text
Time
 │
 ├── Morning
 ├── Day
 └── Night
      │
      ▼
 tmux-theme.sh
      │
      ├── Status bar
      ├── Windows
      ├── Pane borders
      ├── Messages
      ├── Copy mode
      ├── Popups
      └── Menus
```

---

# 🧠 Neovim Integration

Neovim can automatically switch between the iSheild themes:

```text
isheild-morning
isheild-day
isheild-night
```

The Neovim integration follows the same schedule as the other iSheild environments.

This keeps the editor visually synchronized with the terminal and tmux.

---

# 💻 VS Code Integration

iSheild provides a VS Code extension with three themes:

```text
iSheild Morning
iSheild Day
iSheild Night
```

The extension automatically selects the appropriate theme based on the time of day.

For VS Code-specific documentation, see:

```text
vscode-extension/README.md
```

---

# 🚀 Installation

## Linux Terminal + tmux

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/iSheild.git
cd iSheild
```

Run the terminal installer:

```bash
./terminal/install.sh
```

The installer:

1. Installs the iSheild Ptyxis palettes.
2. Detects the default Ptyxis profile.
3. Configures the initial terminal phase.
4. Enables tmux integration when tmux is installed.
5. Installs the iSheild systemd user service.
6. Installs the iSheild systemd user timer.
7. Enables the timer.

Once installed, iSheild automatically keeps the terminal and tmux environment synchronized with the current phase.

> **Note:** The current terminal integration is specifically designed for GNOME Ptyxis on Linux.

---

# 📋 Requirements

## Terminal

- Linux
- GNOME Ptyxis
- `gsettings`
- systemd user services

## tmux

- tmux 3.x

tmux integration is optional. If tmux is not installed, the terminal installer skips tmux-specific setup.

## Neovim

- Neovim
- Lua configuration support

## VS Code

- Visual Studio Code

---

# 🔧 Manual Commands

## Apply the current terminal phase

```bash
./terminal/switch-palette.sh
```

This determines the current time and applies the corresponding Ptyxis palette.

## Apply a specific tmux phase

```bash
./terminal/tmux-theme.sh morning
./terminal/tmux-theme.sh day
./terminal/tmux-theme.sh night
```

## Automatically determine and apply the tmux phase

```bash
./terminal/switch-tmux.sh
```

## Check the systemd timer

```bash
systemctl --user status isheild-terminal.timer
```

## Check the iSheild terminal service

```bash
systemctl --user status isheild-terminal.service
```

## View recent service activity

```bash
journalctl --user -u isheild-terminal.service -n 20 --no-pager
```

---

# 🛑 Uninstall

To disable automatic terminal/tmux switching:

```bash
systemctl --user disable --now isheild-terminal.timer
```

Remove the installed systemd units:

```bash
rm -f ~/.config/systemd/user/isheild-terminal.service
rm -f ~/.config/systemd/user/isheild-terminal.timer
systemctl --user daemon-reload
```

Remove the iSheild Ptyxis palettes:

```bash
rm -f ~/.local/share/org.gnome.Ptyxis/palettes/isheild-*.palette
```

> **Note:** Removing the palettes does not modify other Ptyxis palettes.

---

# 📁 Project Structure

```text
iSheild/
│
├── README.md
├── .gitignore
│
├── terminal/
│   ├── install.sh
│   ├── switch-palette.sh
│   ├── switch-tmux.sh
│   ├── tmux-theme.sh
│   │
│   ├── palettes/
│   │   ├── isheild-morning.palette
│   │   ├── isheild-day.palette
│   │   └── isheild-night.palette
│   │
│   └── systemd/
│       ├── isheild-terminal.service
│       └── isheild-terminal.timer
│
└── vscode-extension/
    ├── extension.js
    ├── package.json
    ├── README.md
    └── themes/
        ├── isheild-morning-color-theme.json
        ├── isheild-day-color-theme.json
        └── isheild-night-color-theme.json
```

---

# 🏗️ Design Philosophy

iSheild is built around a simple idea:

> **Your tools should disappear into your workflow.**

You should not have to manually change:

```text
VS Code
Neovim
Terminal
tmux
```

throughout the day.

Instead, iSheild keeps them visually synchronized so your development environment changes naturally with the time of day.

The project is intentionally built around a small number of consistent visual roles:

```text
Background
Surface
Hover
Selection
Text
Muted
Border
Accent
```

Each phase gives those roles a different visual character while maintaining a consistent overall design language.

---

# 🔮 Roadmap

iSheild is evolving toward a broader cross-platform adaptive development environment.

Potential future directions include:

- Windows support
- macOS support
- additional Linux terminal emulators
- additional terminal integrations
- system-wide screen color temperature adaptation
- more editor integrations
- centralized configuration
- graphical configuration UI
- configurable phase schedules
- custom user palettes
- additional desktop environment integrations

The current implementation focuses on establishing the core time-aware development workflow first.

---

# 🤝 Contributing

Contributions are welcome.

If you want to improve iSheild:

1. Fork the repository.
2. Create a feature branch.
3. Make your changes.
4. Test the integration on your Linux environment.
5. Open a pull request.

For theme changes, please preserve the overall iSheild visual language and explain why the change improves readability, focus, or consistency.

---

# 👤 Author

**jediOTW**

Built for developers who spend a lot of time in front of a screen.

---

# 📄 License

MIT License

Copyright (c) 2026 jediOTW

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files, to deal in the Software
without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
