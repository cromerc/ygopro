--魂縛門
function c500000149.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(500000149,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetTarget(c500000149.tg)
	e2:SetOperation(c500000149.op)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c500000149.filter(c,e,tp)
	local lp=Duel.GetLP(tp)
	return c:IsFaceup() and c:IsDestructable() and c:GetAttack()<=lp and (not e or c:IsRelateToEffect(e))
end
function c500000149.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c500000149.filter,1,nil,nil,tp) end
	local g=eg:Filter(c500000149.filter,nil,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,800)
end
function c500000149.op(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c500000149.filter,nil,e,tp)
	if g:GetCount()>0 and Duel.Destroy(g,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,800,REASON_EFFECT,true)
		Duel.Damage(tp,800,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end
