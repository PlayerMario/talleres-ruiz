package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class ClienteNoDisponible extends EntityNotFoundException {

    public ClienteNoDisponible() {
        super("Ya tiene una cita asignada para el día y hora elegido");
    }

}
