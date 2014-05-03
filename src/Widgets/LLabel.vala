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

public enum FontSize {
	SMALL,
	MEDIUM,
	LARGE
}

public class LLabel : Gtk.Label {
	static const string TEXT_FORMAT =
		"<b><span font='Ubuntu Bold %d' foreground='white'>%s</span></b>";
	FontSize fs;
	string text;
	
	public LLabel (string ltext, FontSize fsize = FontSize.SMALL) {
		set_use_markup (true);
		fs = fsize;		text = ltext;
		set_markup (build_markup ());
		margin_left = 20;
		margin_right = 20;
	}

	public new void set_text (string text) {
		this.text = text;
		set_markup (build_markup ());
	}
	private string build_markup () {
		switch (this.fs) {
		case FontSize.SMALL:
			return TEXT_FORMAT.printf (12, text);
		case FontSize.LARGE:
			return TEXT_FORMAT.printf (35, text);
		/* Medium is the default*/
		default:
			return TEXT_FORMAT.printf (20, text);
		}
	}

}

