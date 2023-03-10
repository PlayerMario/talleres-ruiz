package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.VerificarPasswordValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = VerificarPasswordValidator.class)
public @interface VerificarPassword {

    String message() default "Las contraseñas no coinciden";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    String password();

    String verifyPassword();

}
