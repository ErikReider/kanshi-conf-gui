/* parser.vala
 *
 * Copyright 2021 Erik Reider
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class Profile {
    public Array<Monitor> monitors = new Array<Monitor>();
    public string name;

    public Profile (string name) {
        this.name = name;
    }
}

public class Monitor {
    public string output;
    public bool disabled = false;
    public string mode;
    public string position;
    public string scale;
    public string transform;
    public string exec;

    public void print_values () {
        print ("%s %s %s %s %s %s %s \n", output, mode, position, disabled.to_string (), scale, transform, exec);
    }
}

public class Parser {
    private Profile current_profile;
    private int index = 1;
    public Array<Profile> profiles = new Array<Profile>();

    public Parser (File file) {
        try {
            var dis = new DataInputStream (file.read ());
            string line;
            while ((line = dis.read_line (null)) != null) read_line (line.strip ());
        } catch (Error e) {
            error ("%s", e.message);
        }
    }

    private void read_line (string line) {
        if (line[line.length - 1] == '{') {
            var split = line.split (" ");
            if (!split[0].has_prefix ("profile")) {
                print ("Kanshi config formatted incorrectly!");
                Process.exit (1);
            }
            string name = (split[1] ?? "").replace ("{", "");
            if (name == "") name = "Unnamed profile " + index.to_string ();
            current_profile = new Profile (name);
            index++;
        } else if (line[0] == '}') {
            profiles.append_val (current_profile);
        } else {
            string[] props = line.split (" ");
            Monitor monitor = new Monitor ();
            if (props[0] == "output") {
                monitor.output = props[1];
                for (int i = 2; i < props.length; i++) {
                    switch (props[i]) {
                        case "disable":
                            monitor.disabled = true;
                            break;
                        case "mode":
                            monitor.mode = props[i + 1];
                            i++;
                            break;
                        case "position":
                            monitor.position = props[i + 1];
                            i++;
                            break;
                        case "scale":
                            monitor.scale = props[i + 1];
                            i++;
                            break;
                        case "transform":
                            monitor.transform = props[i + 1];
                            i++;
                            break;
                    }
                }
                current_profile.monitors.append_val (monitor);
            } else if (props[0] == "exec") {
                monitor.exec = line.substring ("exec ".length, -1);
                current_profile.monitors.append_val (monitor);
            }
        }
    }
}
