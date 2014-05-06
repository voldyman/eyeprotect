/**
 * Copyright 2014 Akshay Shekher
 *
 * This file is part of eyeProtect.
 *
 * eyeProtect is free software: you can redistribute it
 * and/or modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * eyeProtect is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 * Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with eyeProtect. If not, see http://www.gnu.org/licenses/.
 *
 * Author: Akshay Shekher <voldyman666@gmail.com>
 */

public class eyeProtectApplication : Granite.Application {

    public  Settings settings { get; private set; default = null; }
//    public static Gtk.IconTheme icon_theme { get; set; default = null; }
	private Indicator indicator;

    construct {

        build_data_dir = Build.DATADIR;
        build_pkg_data_dir = Build.PKGDATADIR;
        build_release_name = Build.RELEASE_NAME;
        build_version = Build.VERSION;
        build_version_info = Build.VERSION_INFO;

        program_name = "eyeProtect";
	    exec_name = "i-protect";
	    app_copyright = "GPLv3";
	    app_icon = "";
	    app_launcher = "";
        app_years = "2014";
        application_id = "com.tripent.iprotect";
	    main_url = "https://github.com/voldyman/iprotect";
	    bug_url = "https://github.com/voldyman/iprotect/issues";

	    about_authors = {"Akshay Shekher <voldyman666@gmail.com>"};
		
        about_license_type = Gtk.License.GPL_3_0;
    }

    public eyeProtectApplication () {
        settings = new Settings ();
    }

    protected override void activate () {
		indicator = new Indicator (this);
		new MainLoop ().run ();
    }

    public static int main (string[] args) {
        var app = new eyeProtectApplication ();

        return app.run (args);
    }

}