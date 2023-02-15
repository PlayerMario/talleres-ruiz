package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.UserUsernameExistsValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UserUsernameExistsValidator.class)
public @interface UserUsernameExists {

    String message() default "No se encuentra el usuario por su nombre de usuario";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
