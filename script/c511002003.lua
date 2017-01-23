--Performapal Extra Shooter
function c511002003.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95100065,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c511002003.damcost)
	e2:SetTarget(c511002003.damtg)
	e2:SetOperation(c511002003.damop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95100065,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetTarget(c511002003.destg)
	e3:SetOperation(c511002003.desop)
	c:RegisterEffect(e3)
	Duel.AddCustomActivityCounter(511002003,ACTIVITY_SPSUMMON,c511002003.counterfilter)
end
function c511002003.counterfilter(c)
	return c:GetSummonType()~=SUMMON_TYPE_PENDULUM
end
function c511002003.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(511002003,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c511002003.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c511002003.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return sumtype==SUMMON_TYPE_PENDULUM
end
function c511002003.damfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c511002003.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c511002003.damfilter,tp,LOCATION_EXTRA,0,nil)
	if chk==0 then return ct>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*300)
end
function c511002003.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(c511002003.damfilter,tp,LOCATION_EXTRA,0,nil)
	Duel.Damage(p,ct*300,REASON_EFFECT)
end
function c511002003.filter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsDestructable()
end
function c511002003.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c511002003.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002003.filter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511002003.filter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c511002003.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Damage(1-tp,300,REASON_EFFECT)
	end
end
