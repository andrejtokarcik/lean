/-
Copyright (c) 2017 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Leonardo de Moura
-/
prelude
import init.meta.smt.smt_tactic init.meta.interactive

namespace smt_tactic
meta def skip : smt_tactic unit :=
return ()

meta def solve_goals : smt_tactic unit :=
repeat close

meta def step {α : Type} (tac : smt_tactic α) : smt_tactic unit :=
tac >> solve_goals

meta def execute (tac : smt_tactic unit) : tactic unit :=
using_smt tac

meta def execute_with (cfg : smt_config) (tac : smt_tactic unit) : tactic unit :=
using_smt_core cfg tac

namespace interactive
open interactive.types

meta def intros : smt_tactic unit :=
smt_tactic.intros

meta def close : smt_tactic unit :=
smt_tactic.close

meta def ematch : smt_tactic unit :=
smt_tactic.ematch

meta def apply (q : qexpr0) : smt_tactic unit :=
tactic.interactive.apply q

meta def fapply (q : qexpr0) : smt_tactic unit :=
tactic.interactive.fapply q

meta def apply_instance : smt_tactic unit :=
tactic.apply_instance

meta def change (q : qexpr0) : smt_tactic unit :=
tactic.interactive.change q

meta def exact (q : qexpr0) : smt_tactic unit :=
tactic.interactive.exact q

meta def assert (h : ident) (c : colon_tk) (q : qexpr0) : smt_tactic unit :=
do e ← tactic.to_expr_strict q,
   smt_tactic.assert h e

meta def define (h : ident) (c : colon_tk) (q : qexpr0) : smt_tactic unit :=
do e ← tactic.to_expr_strict q,
   smt_tactic.define h e

meta def assertv (h : ident) (c : colon_tk) (q₁ : qexpr0) (a : assign_tk) (q₂ : qexpr0) : smt_tactic unit :=
do t ← tactic.to_expr_strict q₁,
   v ← tactic.to_expr_strict `((%%q₂ : %%t)),
   smt_tactic.assertv h t v

meta def definev (h : ident) (c : colon_tk) (q₁ : qexpr0) (a : assign_tk) (q₂ : qexpr0) : smt_tactic unit :=
do t ← tactic.to_expr_strict q₁,
   v ← tactic.to_expr_strict `((%%q₂ : %%t)),
   smt_tactic.definev h t v

meta def note (h : ident) (a : assign_tk) (q : qexpr0) : smt_tactic unit :=
do p ← tactic.to_expr_strict q,
   smt_tactic.note h p

meta def pose (h : ident) (a : assign_tk) (q : qexpr0) : smt_tactic unit :=
do p ← tactic.to_expr_strict q,
   smt_tactic.pose h p

meta def add_fact (q : qexpr0) : smt_tactic unit :=
do h ← tactic.get_unused_name `h none,
   p ← tactic.to_expr_strict q,
   smt_tactic.note h p

meta def trace_state : smt_tactic unit :=
smt_tactic.trace_state

meta def destruct (q : qexpr0) : smt_tactic unit :=
do p ← tactic.to_expr_strict q,
   smt_tactic.destruct p

meta def by_cases (q : qexpr0) : smt_tactic unit :=
do p ← tactic.to_expr_strict q,
   smt_tactic.by_cases p

meta def by_contradiction : smt_tactic unit :=
smt_tactic.by_contradiction

end interactive
end smt_tactic
