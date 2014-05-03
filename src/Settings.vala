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

public class Settings : Granite.Services.Settings {
	public bool launch_on_boot { get; set; }
	public bool activate_on_start { get; set; }
	public int time_to_wait { get; set; }

	public Settings ()  {
		base ("org.pantheon.iprotect");
	}
}