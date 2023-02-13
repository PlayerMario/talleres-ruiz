package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class MecanicoNoDisponible extends EntityNotFoundException {

    public MecanicoNoDisponible() {
        super("El mecánico asignado tiene ocupada ese día y hora");
    }

}
