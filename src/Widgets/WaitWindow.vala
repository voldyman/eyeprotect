/**
 * Copyright 2014 Akshay Shekher
 *
 * This file is part of iProtect.
 *
 * iProtect is free software: you can redistribute it
 * and/or modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * iProtect is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with iProtect. If not, see http://www.gnu.org/licenses/.
 *
 * Author: Akshay Shekher <voldyman666@gmail.com>
 */

using Gtk;

public class WaitWindow : Window {

    static const string CSS =
        "GtkWindow { background-color: shade(rgba(49, 49, 49, 0.6), 0.4); }
        GtkGrid { background-color: rgba(0, 0, 0, 0.5); border-radius: 10px; padding: 10px; }";

    private Grid grid;
    private LLabel time_label;
    int time;

    public signal void wait_finished ();

    public WaitWindow () {
        Object (type: Gtk.WindowType.POPUP);
        setup_window ();
        setup_ui ();

        time = 60;
    }

    public override void show_all () {
        base.show_all ();
        start ();
    }

    public void start () {
        Timeout.add (1 * 1000, timer_func);
    }
    private void setup_window () {
        set_type_hint (Gdk.WindowTypeHint.DOCK);
        title = "Wait";
        window_position = WindowPosition.CENTER;
        decorated = false;

        set_visual (get_screen ().get_rgba_visual());
    }

    private void setup_ui () {
        grid = new Grid ();
        grid.set_orientation (Orientation.VERTICAL);
        grid.halign = Align.CENTER;
        grid.valign = Align.CENTER;

        time_label = new LLabel ("Wait ", FontSize.LARGE);
        grid.add (time_label);

        var info_label = new LLabel (_("Time for a break"), FontSize.MEDIUM);
        info_label.margin_bottom = 10;
        grid.add (info_label);

        set_default_geometry (screen.get_width (), screen.get_height ());

        Granite.Widgets.Utils.set_theming (this, CSS, Granite.StyleClass.COMPOSITED,
                                           Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
        Granite.Widgets.Utils.set_theming (grid, CSS, Granite.StyleClass.COMPOSITED,
                                           Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        key_press_event.connect (key_press_handler);
        add (grid);
    }
    private bool key_press_handler (Gdk.EventKey ev) {
        if (ev.keyval == Gdk.Key.Escape) {
            destroy ();
            return true;
        }
        return false;
    }
    private bool timer_func () {
        if (time <= 0) {
            destroy ();
            return false;
        }
        time_label.set_text ("%d".printf (time));
        time--;
        return true;
    }

    public override void map () {
        base.map ();

        Gdk.pointer_grab (get_window (), true, Gdk.EventMask.BUTTON_PRESS_MASK
                          | Gdk.EventMask.BUTTON_RELEASE_MASK
                          | Gdk.EventMask.POINTER_MOTION_MASK,
                          null, null, 0);
        Gdk.keyboard_grab (get_window (), true, 0);

    }
    public override void destroy () {
        Gdk.pointer_ungrab (0);
        Gdk.keyboard_ungrab (0);

        base.destroy ();
    }
}
