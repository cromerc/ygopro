--Quiz Panel - Slifer 30
os = require('os')
function c51102785.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(51102785,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c51102785.operation)
	c:RegisterEffect(e1)
end
function c51102785.operation(e,tp,eg,ep,ev,re,r,rp)
	local endtime=0
	local check=true
	local start=os.time()
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(51102785,0))
	endtime=os.time()-start
	if endtime<30 or endtime>32 then
		check=false
	end
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	if check==true then
		Duel.Damage(tp,1200,REASON_EFFECT)
	else
		if Duel.GetAttacker() then
			Duel.Destroy(Duel.GetAttacker(),REASON_EFFECT)
		end
		Duel.Damage(1-tp,1200,REASON_EFFECT)
	end
end
