package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class PasswordEqualException extends EntityNotFoundException {

    public PasswordEqualException() {
        super("La nueva contraseña no puede coincidir con la antigua");
    }

}
