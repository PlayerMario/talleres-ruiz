package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.UniqueDNIValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Documented
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueDNIValidator.class)
public @interface UniqueDNI {

    String message() default "El DNI ya existe";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
