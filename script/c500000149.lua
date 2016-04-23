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
	e2:SetCountLimit(1)
	e2:SetTarget(c500000149.target)
	e2:SetOperation(c500000149.activate)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c500000149.filter(c)
	local lp=Duel.GetLP(c:GetControler())
	return c:IsFaceup() and c:IsDestructable() and c:GetAttack()<=lp
end
function c500000149.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,500000149)==0 and eg:IsExists(c500000149.filter,1,nil) end
	local g=eg:Filter(c500000149.filter,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.RegisterFlagEffect(tp,500000149,RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c500000149.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c500000149.filter,nil)
	if g:GetCount()>0 and Duel.Destroy(g,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,800,REASON_EFFECT)
		Duel.Damage(tp,800,REASON_EFFECT)
	end
end