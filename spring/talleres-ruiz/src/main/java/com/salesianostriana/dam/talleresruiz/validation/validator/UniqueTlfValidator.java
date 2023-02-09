package com.salesianostriana.dam.talleresruiz.validation.validator;

import com.salesianostriana.dam.talleresruiz.services.user.UserService;
import com.salesianostriana.dam.talleresruiz.validation.annotation.UniqueTlf;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class UniqueTlfValidator implements ConstraintValidator<UniqueTlf, String> {

    @Autowired
    private UserService service;

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        return StringUtils.hasText(s) && !service.existsTlf(s);
    }

}
