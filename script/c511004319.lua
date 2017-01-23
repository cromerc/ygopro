--妖精の贈りもの a.k.a Fairy's Gift (DOR)
function c511004319.initial_effect(c)
	--flip effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511004319,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c511004319.flipop)
	c:RegisterEffect(e1)
end
function c511004319.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Recover(tp,800,REASON_EFFECT)	
end


	
