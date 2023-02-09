package com.salesianostriana.dam.talleresruiz.validation.annotation;

import com.salesianostriana.dam.talleresruiz.validation.validator.UniqueMatriculaValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueMatriculaValidator.class)
public @interface UniqueMatricula {

    String message() default "La matrícula ya existe";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
