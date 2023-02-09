package com.salesianostriana.dam.talleresruiz.validation.validator;

import com.salesianostriana.dam.talleresruiz.validation.annotation.VerificarPassword;
import org.springframework.beans.PropertyAccessorFactory;
import org.springframework.util.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class VerificarPasswordValidator implements ConstraintValidator<VerificarPassword, Object> {

    private String passwordField;
    private String verifyPasswordField;

    @Override
    public void initialize(VerificarPassword constraintAnnotation) {
        passwordField = constraintAnnotation.password();
        verifyPasswordField = constraintAnnotation.verifyPassword();
    }

    @Override
    public boolean isValid(Object o, ConstraintValidatorContext constraintValidatorContext) {
        String password = (String) PropertyAccessorFactory
                .forBeanPropertyAccess(o)
                .getPropertyValue(passwordField);

        String verifyPassword = (String) PropertyAccessorFactory
                .forBeanPropertyAccess(o)
                .getPropertyValue(verifyPasswordField);

        return StringUtils.hasText(password) && password.contentEquals(verifyPassword);
    }

}
