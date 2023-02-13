package com.salesianostriana.dam.talleresruiz.validation.validator;

import com.salesianostriana.dam.talleresruiz.services.CitaService;
import com.salesianostriana.dam.talleresruiz.validation.annotation.CheckCitaDateHour;
import org.springframework.beans.factory.annotation.Autowired;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.time.LocalDateTime;

public class CheckCitaDateHourValidator implements ConstraintValidator<CheckCitaDateHour, LocalDateTime> {

    @Autowired
    private CitaService service;

    @Override
    public boolean isValid(LocalDateTime fechaHora, ConstraintValidatorContext constraintValidatorContext) {
        return service.validarFechaHora(fechaHora);
    }

}
