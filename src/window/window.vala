/* window.vala
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

namespace KanshiConfGui {
    [GtkTemplate (ui = "/org/erikr/kanshi-conf-gui/window/window.ui")]
    public class Window : Hdy.ApplicationWindow {
        [GtkChild]
        unowned Hdy.Leaflet leaflet;
        [GtkChild]
        unowned Gtk.Stack configure_stack;
        [GtkChild]
        unowned Gtk.ListBox profiles_listBox;
        // unowned Gtk.StackSidebar profiles_stack_bar;

        public Window (Gtk.Application app, Array<Profile> profiles) {
            Object (application: app);

            profiles_listBox.row_activated.connect (row_click);
            configure_stack.add.connect (stack_on_add);
            configure_stack.remove.connect (stack_on_remove);

            for (var i = 0; i < profiles.data.length; i++) {
                addChild (profiles.data[i], i);
            }
            configure_stack.set_child_visible (false);
            // profiles_stack_bar.show_all();
            // profiles_stack_bar.set_stack(configure_stack);
        }

        [GtkCallback]
        public void back_button_click () {
            if (leaflet.can_swipe_back) leaflet.navigate (Hdy.NavigationDirection.BACK);
        }

        public void row_click (Gtk.ListBox listBox, Gtk.ListBoxRow listBoxRow) {
            configure_stack.set_visible_child_name (listBoxRow.get_name ());
            if (!configure_stack.get_child_visible ()) configure_stack.set_child_visible (true);
            leaflet.navigate (Hdy.NavigationDirection.FORWARD);
        }

        private void addChild (Profile profile, int index) {
            string i = index.to_string ();
            configure_stack.add_titled (new KanshiConfGui.Configure (profile, i, profile.name), i, profile.name);
        }

        private void stack_on_add (Gtk.Container container, Gtk.Widget widget) {
            var conf = (Configure) widget;
            var row = new Gtk.ListBoxRow ();
            row.add (new RowBox (conf.profile, conf.text));
            row.set_name (conf.index);

            profiles_listBox.add (row);
        }

        private void stack_on_remove (Gtk.Container container, Gtk.Widget widget) {
        }
    }
}
