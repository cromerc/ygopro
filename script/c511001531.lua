--Reincarnation of the Seven Emperors
function c511001531.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001531.condition)
	e1:SetTarget(c511001531.target)
	e1:SetOperation(c511001531.operation)
	c:RegisterEffect(e1)
end
function c511001531.cfilter(c)
	local code=c:GetCode()
	local class=_G["c"..code]
	if class==nil then return false end
	local no=class.xyz_number
	return no and no>=101 and no<=107 and c:IsSetCard(0x48)
end
function c511001531.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	local ca=a:GetOverlayGroup():IsExists(c511001531.cfilter,1,nil)
	local cd=d:GetOverlayGroup():IsExists(c511001531.cfilter,1,nil)
	if ca and cd and a:GetAttack()==d:GetAttack() and a:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==0 and a:IsAttackPos() and d:IsAttackPos()
		and d:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==0 then return false end
	if a:IsFaceup() and a:IsType(TYPE_XYZ) and ca and d:IsAttackPos() and a:GetAttack()<=d:GetAttack() and a:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==0 then
		e:SetLabelObject(a)
		return true
	end
	if d:IsFaceup() and d:IsType(TYPE_XYZ) and cd 
		and ((d:GetAttack()<=a:GetAttack() and d:IsAttackPos()) or (d:GetDefense()<a:GetAttack() and d:IsDefensePos()))
		and d:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==0 then
		e:SetLabelObject(d)
		return true
	end
	return false
end
function c511001531.filter(c,e,tp)
	return c:IsRankBelow(3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp)
end
function c511001531.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc and tc:IsAbleToRemove() and tc:GetOverlayGroup():IsExists(Card.IsAbleToRemove,tc:GetOverlayCount(),nil) 
		and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or tc:IsControler(tp))
		and Duel.IsExistingMatchingCard(c511001531.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	local g=tc:GetOverlayGroup()
	g:AddCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,tc:GetOverlayCount()+1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001531.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511001531.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetOperation(c511001531.banop)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	e2:SetLabelObject(e:GetLabelObject())
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	e3:SetReset(RESET_PHASE+PHASE_DAMAGE)
	e:GetLabelObject():RegisterEffect(e3)
end
function c511001531.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c511001531.banop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local g=tc:GetOverlayGroup()
	g:AddCard(tc)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	local tcg=g:GetFirst()
	while tcg do
		tcg:RegisterFlagEffect(511001531,RESET_EVENT+0x1fe0000,0,1)
		tcg=g:GetNext()
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001531.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e1:SetReset(RESET_PHASE+PHASE_BATTLE)
		e1:SetCountLimit(1)
		e1:SetLabelObject(g:GetFirst())
		e1:SetOperation(c511001531.damop2)
		Duel.RegisterEffect(e1,tp)
		g:GetFirst():CreateEffectRelation(e1)
	else
		local cg=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
		if cg and cg:GetCount()>0 then
			Duel.ConfirmCards(1-tp,cg)
		end
	end
end
function c511001531.damop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_CARD,0,511001531)
		Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
	end
end
