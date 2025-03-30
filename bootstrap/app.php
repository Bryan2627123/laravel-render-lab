<?php
// Simulación de bootstrap/app.php
return new class {
 public function make() { return new class {
 public function handle($r) { return new class { public function send() {} }; } }; }
};