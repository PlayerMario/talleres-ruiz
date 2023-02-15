package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class OperacionDenegadaException extends EntityNotFoundException {

    public OperacionDenegadaException(String mensaje) {
        super(mensaje);
    }

}
