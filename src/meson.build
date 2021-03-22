kanshi_conf_gui_sources = [
  'main.vala',
  'window/window.vala',
  'parser/parser.vala',
  'configure/configure.vala',
  'row/row.vala',
]

kanshi_conf_gui_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('libhandy-1', version: '>= 1.0.0'),
]

add_project_arguments (
  '-DHANDY_USE_UNSTABLE_API',
  language: 'c'
)

# FIXME Disable --disable-since-check after libhandy 1.0 is released
add_project_arguments (
  # '--disable-since-check',
  language: 'vala'
)


gnome = import('gnome')

kanshi_conf_gui_sources += gnome.compile_resources('kanshi_conf_gui-resources',
  'kanshi_conf_gui.gresource.xml',
  c_name: 'kanshi_conf_gui'
)

executable('kanshi-conf-gui', kanshi_conf_gui_sources,
  vala_args: '--target-glib=2.50',  dependencies: kanshi_conf_gui_deps,
  install: true,
)
