package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class BorrarAdminException extends EntityNotFoundException {

    public BorrarAdminException() {
        super("No se puede puede borrar un admin");
    }

}
