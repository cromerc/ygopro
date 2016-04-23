--幻惑
function c100000504.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local sg=Group.CreateGroup()
	sg:KeepAlive()
	e1:SetLabelObject(sg)	
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetLabelObject(sg)	
	e2:SetCondition(c100000504.scon)
	e2:SetTarget(c100000504.stg)
	e2:SetOperation(c100000504.activate)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e2:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)	
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(0,LOCATION_MZONE)
	e6:SetCode(EFFECT_SET_ATTACK_FINAL)
	e6:SetLabelObject(sg)	
	e6:SetTarget(c100000504.filter3)
	e6:SetValue(c100000504.val)
	c:RegisterEffect(e6)	
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e7:SetCode(EVENT_ADJUST)
	e7:SetRange(LOCATION_SZONE)	
	e7:SetLabelObject(sg)
	e7:SetCondition(c100000504.scon2)
	e7:SetOperation(c100000504.sop)
	c:RegisterEffect(e7)
end
function c100000504.filter(c)
	return c:IsSetCard(0x5008) and c:IsFaceup()
end
function c100000504.scon(e,tp,eg,ep,ev,re,r,rp)
	local vh=Duel.GetMatchingGroup(c100000504.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	return vh:GetCount()>0 and e:GetHandler():GetFlagEffect(100000504)==0
	 and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
end
function c100000504.stg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(100000504)==0 end
	c:RegisterFlagEffect(100000504,RESET_EVENT+0x1fe0000,0,1)	
end
function c100000504.activate(e,tp,eg,ep,ev,re,r,rp)	
	local c=e:GetHandler()	
	local sg=e:GetLabelObject()
	local dg=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),0,LOCATION_MZONE,nil)
	Duel.Hint(HINT_SELECTMSG,c:GetControler(),HINTMSG_FACEUP)
	local tdg=dg:Select(c:GetControler(),1,1,nil)
	local tc=tdg:GetFirst()	
	if tc and tc:IsFaceup() then
		sg:AddCard(tc)
	end
end
function c100000504.filter3(e,c)
	local g=e:GetLabelObject():GetFirst()
	return c==g
end
function c100000504.val(e,c)
	return c:GetAttack()/2
end
function c100000504.scon2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject():GetFirst()
	local vh=Duel.GetMatchingGroup(c100000504.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g then
	return e:GetHandler():GetFlagEffect(100000504)~=0 and (not g:IsLocation(LOCATION_MZONE) or vh:GetCount()==0)
	else return false end
end
function c100000504.sop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=e:GetLabelObject()
	c:ResetFlagEffect(100000504)
	sg:Clear()
end