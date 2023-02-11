package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.PasswordNotEqualValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = PasswordNotEqualValidator.class)
public @interface PasswordNotEqual {

    String message() default "Las contraseñas debe coindicir con la antigua";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    String password();

    String verifyPassword();

}
