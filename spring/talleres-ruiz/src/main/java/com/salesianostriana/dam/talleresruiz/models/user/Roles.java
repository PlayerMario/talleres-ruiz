package com.salesianostriana.dam.talleresruiz.models.user;

public enum Roles {

    ADMIN, MEC, CLIENTE;

    public static boolean contains(String text) {
        try {
            Roles.valueOf(text);
            return true;
        } catch (IllegalArgumentException ex) {
            return false;
        }
    }

}
