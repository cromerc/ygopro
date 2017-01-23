--Cyber Angel - Vishnu
function c511009071.initial_effect(c)
	 c:EnableReviveLimit()
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c511009071.destg)
	e2:SetOperation(c511009071.desop)
	c:RegisterEffect(e2)
end


function c511009071.desfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsDestructable()
end
function c511009071.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511009071.desfilter,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*1000)
end
function c511009071.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009071.desfilter,tp,0,LOCATION_MZONE,nil)
	
	local g=Duel.GetMatchingGroup(c511009071.desfilter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if Duel.Damage(1-tp,ct*1000,REASON_EFFECT)~=0 then
		local c=e:GetHandler()
		local atk=ct-1
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
