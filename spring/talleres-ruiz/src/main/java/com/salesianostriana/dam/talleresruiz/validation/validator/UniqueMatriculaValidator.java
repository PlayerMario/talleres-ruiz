package com.salesianostriana.dam.talleresruiz.validation.validator;

import com.salesianostriana.dam.talleresruiz.services.ClienteService;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UniqueMatricula;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class UniqueMatriculaValidator implements ConstraintValidator<UniqueMatricula, String> {

    @Autowired
    private ClienteService service;

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        return StringUtils.hasText(s) && !service.existsMatricula(s);
    }

}
