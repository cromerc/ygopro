--Ｔｈｅ ｔｒｉｐｐｉｎｇ ＭＥＲＣＵＲＹ
function c100000303.initial_effect(c)
	--summon with 3 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c100000303.ttcon)
	e1:SetOperation(c100000303.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE+1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c100000303.destg)
	e2:SetOperation(c100000303.desop)
	c:RegisterEffect(e2)
end
function c100000303.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetTributeCount(c)>=3
end
function c100000303.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g, REASON_SUMMON+REASON_MATERIAL)
end
function c100000303.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler(),TYPE_MONSTER)>0 end
	if e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE+1 then
		local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler(),TYPE_MONSTER)
		Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
	else
		e:SetCategory(CATEGORY_ATKCHANGE)
	end
end
function c100000303.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE+1 then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	else
		local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler(),TYPE_MONSTER)
		Duel.ChangePosition(g,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
