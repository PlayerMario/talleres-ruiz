package com.salesianostriana.dam.talleresruiz.errors.exceptions;

public class StorageException extends RuntimeException {

    public StorageException(String mensaje) {
        super(mensaje);
    }

    public StorageException(String mensaje, Exception exception) {
        super(mensaje, exception);
    }

}
