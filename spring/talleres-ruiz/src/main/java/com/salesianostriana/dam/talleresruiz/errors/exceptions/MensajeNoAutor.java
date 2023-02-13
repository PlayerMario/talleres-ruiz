package com.salesianostriana.dam.talleresruiz.errors.exceptions;

import javax.persistence.EntityNotFoundException;

public class MensajeNoAutor extends EntityNotFoundException {

    public MensajeNoAutor() {
        super("La cita no pertenece al usuario que intenta enviar el mensaje");
    }

}
