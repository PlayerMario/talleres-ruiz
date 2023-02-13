package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class CitaNoModificable extends EntityNotFoundException {

    public CitaNoModificable() {
        super("No se puede modificar una cita en este estado");
    }

}
