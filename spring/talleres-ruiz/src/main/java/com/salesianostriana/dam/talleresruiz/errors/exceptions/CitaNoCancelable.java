package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class CitaNoCancelable extends EntityNotFoundException {

    public CitaNoCancelable() {
        super("No se puede cancelar una cita en proceso de realización o ya terminada");
    }

}
