--エコール・ド・ゾーン
function c500000147.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(500000147,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c500000147.target)
	e2:SetOperation(c500000147.activate)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--cannot direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(c500000147.atktarget)
	c:RegisterEffect(e4)
end
function c500000147.atktarget(e,c)	
	return not c:IsType(TYPE_TOKEN)
end
function c500000147.filter(c,tp,ep)
	local tpe=c:GetType()
	return c:IsFaceup() and c:IsDestructable() and bit.band(tpe,TYPE_TOKEN)==0
end
function c500000147.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return eg:IsExists(c500000147.filter,1,nil,tp) end
	local g=eg:Filter(c500000147.filter,nil,tp)
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c500000147.filter3(c,e,tp)
	local tpe=c:GetType()
	return c:IsFaceup() 
	and c:IsDestructable()  and bit.band(tpe,TYPE_TOKEN)==0
end
function c500000147.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c500000147.filter3,nil,e,tp)
	if g:GetCount()>0 then
		local atk=g:GetFirst():GetAttack()
		local def=g:GetFirst():GetDefense()
		local con=g:GetFirst():GetControler()
		local pos=g:GetFirst():GetPosition()
		if Duel.Destroy(g,REASON_EFFECT)~=0 then
		local token=Duel.CreateToken(tp,500000148)		
		Duel.SpecialSummonStep(token,0,con,con,false,false,pos)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(def)
		token:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
	end
end
end
