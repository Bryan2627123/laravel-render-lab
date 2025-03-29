<?php

$app = new class {
    public function make($abstract) {
        return new class {
            public function handle($request) {
                return new class {
                    public function send() {
                        echo "<h1>¡Laravel Render funciona correctamente!</h1>";
                        return $this;
                    }
                };
            }

            public function terminate($request, $response) {}
        };
    }
};

return $app;
