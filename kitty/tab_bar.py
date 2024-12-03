from kitty.fast_data_types import Screen
from kitty.rgb import Color
from kitty.tab_bar import DrawData, ExtraData, Formatter, TabBarData, as_rgb, draw_title
from kitty.utils import color_as_int

ICON_FG = as_rgb(color_as_int(Color(78, 81, 82)))

LEFT_SEP = ""
RIGHT_SEP = ""

ICON_SEP_COLOR_FG = as_rgb(color_as_int(Color(157, 205, 105)))
ICON_SEP_COLOR_BG = as_rgb(color_as_int(Color(16, 16, 16)))


def __draw_icon(screen: Screen, index: int) -> int:
    if index != 1:
        return 0
    icon_fg, icon_bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg = ICON_SEP_COLOR_FG
    screen.cursor.bg = ICON_SEP_COLOR_BG
    screen.cursor.fg, screen.cursor.bg = icon_fg, icon_bg
    end = screen.cursor.x
    return end


def __draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    max_tab_length: int,
    index: int,
    extra_data: ExtraData,
) -> int:
    tab_bg = screen.cursor.bg
    default_bg = as_rgb(int(draw_data.default_bg))

    # Set colors for LEFT_SEP to match RIGHT_SEP
    screen.cursor.fg = tab_bg  # Use the tab background color as foreground for LEFT_SEP
    screen.cursor.bg = default_bg  # Set the default background color for LEFT_SEP
    screen.draw(LEFT_SEP)

    # Restore the tab background color for the main tab content
    screen.cursor.fg = ICON_FG  # Use the defined icon foreground color
    screen.cursor.bg = tab_bg  # Main tab background
    draw_title(draw_data, screen, tab, index, max_tab_length)

    # Draw a space after the tab title for separation
    screen.draw(" ")  # Add a space between the tabs

    # Set colors for RIGHT_SEP
    screen.cursor.bg = default_bg  # Set the default background color for RIGHT_SEP
    screen.cursor.fg = (
        tab_bg  # Use the tab background color as foreground for RIGHT_SEP
    )
    screen.draw(RIGHT_SEP)

    # Optional: Add an additional space after the right separator if needed
    screen.draw(" ")

    end = screen.cursor.x
    return end


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    __draw_icon(screen, index)
    end = __draw_tab(draw_data, screen, tab, max_title_length, index, extra_data)
    return end
