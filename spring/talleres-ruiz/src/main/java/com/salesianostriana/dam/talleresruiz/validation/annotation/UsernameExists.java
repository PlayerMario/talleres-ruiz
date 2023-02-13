package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.UsernameExistsValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UsernameExistsValidator.class)
public @interface UsernameExists {

    String message() default "No se encuentra el nombre de usuario";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
