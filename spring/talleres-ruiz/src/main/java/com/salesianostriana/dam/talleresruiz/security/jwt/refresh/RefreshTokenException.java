package com.salesianostriana.dam.talleresruiz.security.jwt.refresh;


import com.salesianostriana.dam.talleresruiz.security.errorhandling.JwtTokenException;

public class RefreshTokenException extends JwtTokenException {

    public RefreshTokenException(String msg) {
        super(msg);
    }

}


