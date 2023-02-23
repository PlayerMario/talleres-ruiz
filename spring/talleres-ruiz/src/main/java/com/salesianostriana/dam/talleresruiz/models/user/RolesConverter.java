package com.salesianostriana.dam.talleresruiz.models.user;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.util.Arrays;
import java.util.EnumSet;
import java.util.stream.Collectors;

@Converter
public class RolesConverter implements AttributeConverter<EnumSet<Roles>, String> {

    private final String SEPARADOR = ", ";

    @Override
    public String convertToDatabaseColumn(EnumSet<Roles> attribute) {
        if (!attribute.isEmpty()) {
            return attribute.stream()
                    .map(Roles::name)
                    .collect(Collectors.joining(SEPARADOR));
        }
        return null;
    }

    @Override
    public EnumSet<Roles> convertToEntityAttribute(String dbData) {
        if (dbData != null) {
            if (!dbData.isBlank()) {
                return Arrays.stream(dbData.split(SEPARADOR))
                        .map(elem -> Roles.valueOf(elem))
                        .collect(Collectors.toCollection(() -> EnumSet.noneOf(Roles.class)));
            }
        }
        return EnumSet.noneOf(Roles.class);
    }

}
