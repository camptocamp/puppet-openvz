/*

== Class: openvz::server

Simple wrapper. Include os-dependent class.
Those classes will activate repositories, install packages,
and maybe configure some stuff on the server

*/
class openvz::server {
    include openvz::params, openvz::server::rhel
}
