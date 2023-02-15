package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class BuscarFicheroException extends EntityNotFoundException {

    public BuscarFicheroException(String mensaje) {
        super(mensaje);
    }

}
