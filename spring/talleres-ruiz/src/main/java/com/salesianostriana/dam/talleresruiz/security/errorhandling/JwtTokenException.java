package com.salesianostriana.dam.talleresruiz.security.errorhandling;

public class JwtTokenException extends RuntimeException {

    public JwtTokenException(String msg) {
        super(msg);
    }

}
