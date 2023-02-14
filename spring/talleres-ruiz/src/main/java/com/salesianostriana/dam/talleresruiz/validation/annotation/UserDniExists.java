package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.UserDniExistsValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UserDniExistsValidator.class)
public @interface UserDniExists {

    String message() default "No se encuentra el usuario por su DNI";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
