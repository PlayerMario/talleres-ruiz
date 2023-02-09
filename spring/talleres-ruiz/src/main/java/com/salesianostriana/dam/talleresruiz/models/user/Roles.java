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

    /*
     DTO DE CREAR UNA PERSONA
     public Persona toPersona() {
        // A partir de esta línea, procesamos las aficiones que pueden venir incluidas en el DTO
        EnumSet<Aficiones> aficionesEnumSet = EnumSet.noneOf(Aficiones.class);

        // Si hay alguna afición
        if (aficiones != null) {
            aficionesEnumSet = aficiones.stream()
                        .map(String::toUpperCase)
                        .filter(Aficiones::contains) // Comprobamos a través del método propio contains de la clase model/Aficiones si es una afición válida
                        .map(Aficiones::valueOf) // transformamos a un valor de la enumeración
                        .collect(Collectors.toCollection(() -> EnumSet.noneOf(Aficiones.class))); // los recogemos todos en una colección
        }


        return Persona.builder()
                .nombre(nombre)
                .apellidos(apellidos)
                .fechaNacimiento(fechaNacimiento)
                .aficiones(aficionesEnumSet)
                .build();

    }
    */

}
