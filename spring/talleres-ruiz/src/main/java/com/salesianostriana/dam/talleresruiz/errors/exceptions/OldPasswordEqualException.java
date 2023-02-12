package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class OldPasswordEqualException extends EntityNotFoundException {

    public OldPasswordEqualException() {
        super("La antigua contraseña no coincide con la original");
    }

}
