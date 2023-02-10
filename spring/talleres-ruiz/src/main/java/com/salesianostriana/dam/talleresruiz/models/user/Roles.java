package com.salesianostriana.dam.talleresruiz.models.user;

import java.util.EnumSet;
import java.util.stream.Collectors;

public enum Roles {

    ADMIN, MEC, USER;

    public static boolean contains(String text) {
        try {
            Roles.valueOf(text);
            return true;
        } catch (IllegalArgumentException ex) {
            return false;
        }
    }

}
