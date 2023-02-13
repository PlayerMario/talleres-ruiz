package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class CitaNoCliente extends EntityNotFoundException {

    public CitaNoCliente() {
        super("La cita no pertenece al cliente especificado");
    }

}
